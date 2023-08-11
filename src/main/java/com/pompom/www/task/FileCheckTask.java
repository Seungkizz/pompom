package com.pompom.www.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.pompom.www.upload.dto.AttachDTO;
import com.pompom.www.upload.mapper.UploadMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {

	@Setter(onMethod_ = { @Autowired })
	private UploadMapper uploadMapper;

	private String getFolderYesterDay() {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Calendar cal = Calendar.getInstance();

		cal.add(Calendar.DATE, -1);

		String str = sdf.format(cal.getTime());

		return str;
	}

	// 스케줄러 어노테이션 - 매일 12 시에 작동
	// DB에는 들어있는 파일을 제외하고 남아있는 이미지를 지우는 스케줄러
	@Scheduled(cron = "0 00 12 * * *")
	
	public void checkFiles() throws Exception {

		log.warn("File Check Task run.................");
		log.warn(new Date());
		// file list in database
		List<AttachDTO> fileList = uploadMapper.getOldFiles();

		// ready for check file in directory with database file list
		List<Path> fileListPaths = fileList.stream().map(vo -> Paths.get("C:\\upload", vo.getUploadpath(), vo.getUuid()+"_"+vo.getFilename()))
				.collect(Collectors.toList());
		// image file has thumnail file
				fileList.stream().filter(vo -> vo.isFiletype() == true)
						.map(vo -> Paths.get("C:\\upload", vo.getUploadpath(), "s_" + vo.getUuid() + "_" + vo.getFilename()))
						.forEach(p -> fileListPaths.add(p));
		log.warn("===========================================");

		fileListPaths.forEach(p -> log.warn(p));

		// files in yesterday directory
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
		// 디비에서 가져온 데이터가 들어있지 않으면 removeFiles 넣어놈
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);

		log.warn("-----------------------------------------");
		for (File file : removeFiles) {

			log.warn(file.getAbsolutePath());

			file.delete();

		}
	}

//	@Scheduled(cron = "0/3 * * * * *")
//	public void	test() {
//		System.out.println("ㅋㅋㅋ");
//	}
}
