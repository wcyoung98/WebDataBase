/**
 * index.jsp 체크박스 전체선택, 전체선택해제 js
 */
function check(index){
		var cbox = table_check.select;
		if(index == 1){
			for(var i = 0; i < cbox.length; i++){
				cbox[i].checked = true;
			}
		} else if(index == 0){
			for(var i = 0; i < cbox.length; i++){
				cbox[i].checked = false;
			}
		}
}

/**
 * index.jsp 체크박스로 선택된 값들 삭제 결정 js
 */
function mySubmit(page){
	if(page == "delete"){
		document.table_check.action="table_delete.jsp";
	} else if(page == "drop"){
		document.table_check.action="table_drop.jsp"
	} else {
		location.href="index.jsp";
	}
	if(confirm("정말로 삭제하시겠습니까?") == true){
		document.table_check.submit();
	} else {
		location.href="index.jsp";
	}
}

/**
 * index.jsp -> create_form.jsp 유효성 체크, submit js
 */
function createSubmit(){
	var form = document.create_form;
	if(form.name.value == "" && form.count.value == ""){
		alert("테이블을 생성하는 데 필요한 값들을 입력해주세요.");
		return;
	} else if(form.name.value == ""){
		alert("테이블명을 입력해주세요.");
		return;
	} else if(form.count.value == "" || form.count.value <= 0){
		alert("필드 수를 제대로 입력해주세요.");
		return;
	}
	form.submit();
}

/**
 * index.jsp -> queryRun.jsp or selectQueryRun.jsp, 유효성체크 js 
 */
function querySubmit(){
	var form = document.query_form;
	var query = form.query.value.split(" ");
	if(query[1] == "*"){
		alert("\'*\' 속성은 위 테이블 목록의 실행[보기] 버튼을 이용해주세요.\n");
		return;
	}
	if(query[0].toUpperCase() == "SELECT"){
		form.action = "selectQueryRun.jsp";
		form.submit();
		return;
	}
	if(form.query.value == ""){
		alert("Query를 작성해주세요.");
		return;
	}
	form.submit();
}

/**
 * select.jsp 체크박스 전체선택, 전체선택해제 js
 */
function selectCheck(index){
	var cbox = document.getElementsByClassName("check");
	for(var i = 0; i < cbox.length; i++){
		if(index == 1){
			cbox[i].checked = true;
		} else if(index == 0){
			cbox[i].checked = false;
		}
	}
}

/**
 * select.jsp 체크박스로 선택된 값들 action결정, confirm js
 */
function submitAction(index){
	var text;
	if(index == 0){
		text = "정말 삭제하시겠습니까?";
		document.selectForm.action="delete.jsp";
	} else if(index == 1){
		text = "정말 수정하시겠습니까?";
		document.selectForm.action="update.jsp";
	} else {
		location.href="index.jsp";
	}
	if(confirm(text) == true){
		document.selectForm.submit();
	} else {
		return;
	}
}

/**
 * select.jsp 삽입버튼 js
 */
function insertHref(table){
	location.href="insert_form.jsp?name="+table;
}

/**
 * insert_form.jsp -> insert_action.jsp 유효성 체크, submit js
 */
function insertSubmit(){
	var form =  document.insert_form;
	if(form.value.length > 1){
		for(var i = 0; i < form.value.length; i++){
			if(form.value[i].value == ""){
				alert((i+1)+"번 째 필드의 값을 입력해주세요.");
				return;
			}
		}
	} else {
		if(form.value.value == ""){
			alert("값을 입력해주세요.");
			return;
		}
	}
	form.submit();
}

/**
 * create_form.jsp -> create_action.jsp 유효성 체크, submit js
 */
function createActionSubmit(){
	var form = document.create_form;
	if(form.fieldName.length > 1){
		for(var i = 0; i < form.fieldName.length; i++){
			if(form.fieldName[i].value == ""){
				alert((i+1)+"번 째 필드명을 입력해주세요.");
				return;
			}
		}
	} else {
		if(form.fieldName.value == ""){
			alert("필드명을 입력해주세요.");ㄴ
			return;
		}
	}
	form.submit();
}

