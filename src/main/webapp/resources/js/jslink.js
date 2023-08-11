//시간표기
 function displayTime(createTimeValue, modifyTimeValue) {
	 
	  var today = new Date();
	  var timeValue = modifyTimeValue || createTimeValue;
	  var gap = today.getTime() - timeValue;
	  var seconds = Math.floor(gap / 1000);
	  var minutes = Math.floor(seconds / 60);
	  var hours = Math.floor(minutes / 60);
	  var days = Math.floor(hours / 24);

	  if (modifyTimeValue && modifyTimeValue > createTimeValue) {
	    
	    return  "약 " + minutes + " 분 전 수정됨";
	  } else if (days >= 1) {
	    var dateObj = new Date(timeValue);
	    var yy = dateObj.getFullYear();
	    var mm = dateObj.getMonth() + 1; // January is 0
	    var dd = dateObj.getDate();
	    return [yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd].join('');
	  } else if (hours >= 1) {
	    return "약 " + hours + " 시간 전";
	  } else if (minutes >= 1) {
	    return "약 " + minutes + " 분 전";
	  } else {
	    return "방금";
	  }
	}
 
function fomatDate(e){
		
	var fomatdate = new Date(e);
			 
	var year = fomatdate.getFullYear();    //0000년 가져오기
	var month = fomatdate.getMonth() + 1;  //월은 0부터 시작하니 +1하기
	var day = fomatdate.getDate();        //일자 가져오기
	
	return year+"/"+month+"/"+day;
}
 

 
 