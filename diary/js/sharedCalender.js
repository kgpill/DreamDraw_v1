document.addEventListener('DOMContentLoaded', function () {
  let currYear = new Date().getFullYear();
  let currMonth = new Date().getMonth();
  console.log(currYear);
  console.log(currMonth);

  const months = [
    'JANUARY',
    'FEBRUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER',
  ];

  const currentDate = document.querySelector('.headText');
  const daysTag = document.querySelector('.dayBar');
  const prevNextIcon = document.querySelectorAll('.leftArrow, .rightArrow');

  const renderCalendar = () => {
  currentDate.innerHTML = `${months[currMonth]} ${currYear}`;
  let lastDateMonth = new Date(currYear, currMonth + 1, 0).getDate();
  let firstDayOfMonth = new Date(currYear, currMonth, 1).getDay();
  let lastDayOfMonth = new Date(currYear, currMonth, lastDateMonth).getDay();
  let lastDateOfLastMonth = new Date(currYear, currMonth, 0).getDate();
  let liTag = '';
  let count = 0;
  
  // 수정된 formatDate 함수
function formatDateForComparison(year, month, day) {
  const mm = String(month + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고 두 자리로 만듭니다.
  const dd = String(day).padStart(2, '0');
  return `${year}/${mm}/${dd}`;
}

  
// renderDate 함수에서 formatDate를 사용하는 부분 수정
const renderDate = (day, isCurrentMonth) => {
  let dayOfWeek = new Date(currYear, currMonth, day).getDay();
  let formattedDate = formatDateForComparison(currYear, currMonth, day);

  // JSON 데이터에 있는 날짜와 현재 생성할 테이블의 날짜가 같으면 체크표시
  const isDateInJson = dateListJson.includes(formattedDate);
  const checkbox = isDateInJson ? ' ✔' : '';

  // 클래스명을 'highlight'로 추가하여 체크박스 스타일 적용
  const liClass = `${isCurrentMonth ? '' : 'inactive'} ${isDateInJson ? 'highlight' : ''} ${formattedDate === formatDateForComparison(new Date().getFullYear(), new Date().getMonth(), new Date().getDate()) ? 'currentDate' : ''}`;

  // 이벤트 핸들러 추가
  const clickHandler = `mydiary(${currYear}, ${currMonth}, ${day}, ${dayOfWeek});`;

  return `<li class="${liClass}" onclick="${clickHandler}">${day}${checkbox}</li>`;
};

  for (let i = firstDayOfMonth; i > 0; i--) {
    liTag += renderDate(lastDateOfLastMonth - i + 1, false);
    count++;
  }

  for (let i = 1; i <= lastDateMonth; i++) {
    liTag += renderDate(i, true);
    count++;
  }

  for (let i = lastDayOfMonth + 1; i < lastDayOfMonth + (35 - count + 1); i++) {
    liTag += renderDate(i - lastDayOfMonth, false);
  }

  daysTag.innerHTML = liTag;
};

  const updateCalendar = (direction) => {
    if (direction === 'leftArrow') {
      currMonth = currMonth - 1;
      if (currMonth < 0) {
        currMonth = 11;
        currYear = currYear - 1;
      }
    } else {
      currMonth = currMonth + 1;
      if (currMonth > 11) {
        currMonth = 0;
        currYear = currYear + 1;
      }
    }

    // 갱신된 currYear를 출력해보자.
    console.log(currYear);

    renderCalendar();
  };

  renderCalendar();

  prevNextIcon.forEach((icon) => {
    icon.addEventListener('click', () => {
      updateCalendar(icon.classList.contains('leftArrow') ? 'leftArrow' : 'rightArrow');
    });
  });
});

// 클릭 이벤트 핸들러 함수인 mydiary를 작성
function mydiary(year, month, day, dayOfWeek) {
	// 클릭한 날짜에 대한 처리를 수행하고, 서버로 데이터를 전송
  var dayName = getDayName(dayOfWeek);
  // 클릭한 날짜에 대한 처리를 수행하고, 서버로 데이터를 전송
  console.log(`Clicked on ${year}년 ${month + 1}월 ${day}일 (${dayName})`);


  // 폼 엘리먼트 생성
  var form = document.createElement('form');
  form.method = 'POST';
     var contextPath = document.getElementById('contextPath').value;
        form.action = contextPath + '/sharedList';

  // 데이터를 폼에 추가
  var yearInput = document.createElement('input');
  yearInput.type = 'hidden';
  yearInput.name = 'year';
  yearInput.value =  encodeURIComponent(year);
  form.appendChild(yearInput);

  var monthInput = document.createElement('input');
  monthInput.type = 'hidden';
  monthInput.name = 'month';
  monthInput.value =  encodeURIComponent(month + 1);  // JavaScript에서 월은 0부터 시작하므로 1을 더해줍니다.
  form.appendChild(monthInput);

  var dayInput = document.createElement('input');
  dayInput.type = 'hidden';
  dayInput.name = 'day';
  dayInput.value = encodeURIComponent(day);
  form.appendChild(dayInput);
  
  var dayNameInput = document.createElement('input');
  dayNameInput.type = 'hidden';
  dayNameInput.name = 'dayName';
  dayNameInput.value = encodeURIComponent(dayName);
  form.appendChild(dayNameInput);

  // 폼을 바디에 추가하고 서브밋
  document.body.appendChild(form);
  form.submit();
}

// 요일 번호(0~6)을 받아 해당 요일의 이름을 반환하는 함수
function getDayName(dayOfWeek) {
  const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  return days[dayOfWeek];
}

// 날짜 형식을 포맷하는 함수
function formatDate(year, month, day) {
    return `${year}/${month + 1}/${day}`;
}
