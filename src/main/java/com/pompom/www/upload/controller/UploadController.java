package com.pompom.www.upload.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pompom.www.member.dto.MemberDTO;
import com.pompom.www.upload.dto.AttachDTO;
import com.pompom.www.upload.dto.AttachFileDTO;
import com.pompom.www.upload.service.UploadService;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/upload/*")
public class UploadController {

	@Autowired
	private UploadService uploadService;

	@PostMapping("/memberImg")
	@ResponseBody
	public ResponseEntity<List<AttachDTO>> uploadMemberImg(MultipartFile[] uploadFile, HttpServletRequest request,
			HttpSession session, int sourceType) {
		// 반환하기 위해서 빈 리스트 하나 생성
		List<AttachDTO> list = new ArrayList<>();

		log.info("sourceType >>>> " + sourceType);

		// 객체를 담을 attachDTO
		AttachDTO attachDTO = new AttachDTO();

		String uploadFolder = "C:\\upload";

		String uploadFolderPath = getFolder();
		// make folder --------
		File uploadPath = new File(uploadFolder, uploadFolderPath);

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		// make yyyy/MM/dd folder

		for (MultipartFile multipartFile : uploadFile) {

			String uploadFileName = multipartFile.getOriginalFilename();

			// IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);
			attachDTO.setFilename(uploadFileName);

			UUID uuid = UUID.randomUUID();

			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);

				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadpath(uploadFolderPath);

				// 이미지체크
				if (checkImageType(saveFile)) {

					attachDTO.setFiletype(true);

					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));

					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);

					thumbnail.close();
				}
				if (sourceType == 1) {
					// add to List
					session = request.getSession();
					MemberDTO memberDTO = (MemberDTO) session.getAttribute("auth");
					String memberId = memberDTO.getMemberId();
					attachDTO.setMemberId(memberId);
					uploadService.insertMemberImg(attachDTO);
					list.add(attachDTO);
					return new ResponseEntity<>(list, HttpStatus.OK);
				} else {
					list.add(attachDTO);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		} // end for
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@ResponseBody
	@DeleteMapping("/deleteImg/{memberId}")
	public ResponseEntity<String> delete(@PathVariable String memberId) {
		log.info("여기왔다" + memberId);
		int result = uploadService.delete(memberId);
		return result == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 이미지 파일 경로 받아서 바이너리 형태로 전달해줌
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {

		log.info("fileName: " + fileName);

		File file = new File("c:\\upload\\" + fileName);

		log.info("file: " + file);
		// 반환해줄 ResponseEntity 선언 하고 NULL초기화
		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();
			// 파일의 경로를 검사
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			// FileCopyUtils.copyToByteArray(file) 파일을 배열로 바꿔줌
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {

		log.info("deleteFile: " + fileName);

		File file;

		try {
			// x 누른 파일의 (이미지 - 썸네일 , 파일일 경우 - 원래경로)썸네일 경로를 decode함
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			// 썸네일 파일 삭제
			file.delete();
			// 파일 타입이 이미지이면
			if (type.equals("image")) {
				// getAbsolutePath: 절대경로
				// s_빼서 원본 경로 만들어줌 - File 객체를 스트링으로 만들어서 글자로 치환
				String largeFileName = file.getAbsolutePath().replace("s_", "");

				log.info("largeFileName: " + largeFileName);
				// 치환한 경로를 다시 파일객체로 만들어줌(delete 메소드 사용하기 위해서)
				file = new File(largeFileName);
				// 그 파일 객체 삭제
				file.delete();
			}

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity<String>("deleted", HttpStatus.OK);

	}

	// 전송 된 파일이 이미지가 아닐 경우 다운로드 (APPLICATION_OCTET_STREAM_VALUE: 8비트로 된 데이터)
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		// 파일 실제 경로 뽑음
		Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
		// 경로 있는지 확인
		if (resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		String resourceName = resource.getFilename();

		// remove UUID
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);

		HttpHeaders headers = new HttpHeaders();
		try {

			String downloadName = null;

			if (userAgent.contains("Trident")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
			} else if (userAgent.contains("Edge")) {
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			} else {
				log.info("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}

			log.info("downloadName: " + downloadName);

			headers.add("Content-Disposition", "attachment; filename=" + downloadName);

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}

	// 년 월 일 폴더 생성
	private String getFolder() {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		String str = sdf.format(date);

		return str;
	}

	// 이미지 파일 체크
	private boolean checkImageType(File file) {

		try {
			String contentType = Files.probeContentType(file.toPath());

			return contentType.startsWith("image");

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}
}
