<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>TITLE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
    <style>
        body{
            background-color:#ccc;
        }
        .col-3, .col-8{
            padding: 10px;
            background-color:#fff;
        }
    </style>
    <script>
        $(document).ready(function() {
            loadStudentAll();
        });
        function loadStudentAll() {
            localStorage.clear();
            $.ajax({
                url: 'student/all',
                type: 'GET',
                success: function(data) {
                    if (data && data.length > 0) {
                        let studentTableBody = '';
                        data.forEach(student => {
                            studentTableBody +=
                                "<tr>" +
                                "<td class='text-center'>" +
                                "<a href='#' class='d-block fs-5 link-secondary link-underline-opacity-0' onclick='handleShow(" + student.name_id + ")'>" +
                                student.name +
                                "</a>" +
                                "</td>" +
                                "</tr>";
                        });
                        $("#studentList").html(studentTableBody);
                    } else {
                        $("#studentList").html("<tr><td colspan='1' class='text-center'>학생이 없습니다.</td></tr>");
                    }
                },
                error: function(xhr, status, error) {
                    console.error('에러 발생:', error);
                    alert('학생 목록을 가져오는 데 실패했습니다.');
                }
            });
        }

        const handleSearch = () =>{
            const name = $('#searchName').val();
            if(!name){
                loadStudentAll()
                return
            }
            searchByName(name);
        }

        const searchByName = name => {
            $.ajax({
                url: 'student/search/'+name,
                type: 'GET',
                success: function(data) {
                    if (data && data.length > 0) {
                        let studentTableBody = '';
                        data.forEach(student => {
                            studentTableBody +=
                                "<tr>" +
                                "<td class='text-center'>" +
                                "<a href='#' class='d-block fs-5 link-secondary link-underline-opacity-0' onclick='handleShow(" + student.name_id + ")'>" +
                                student.name +
                                "</a>" +
                                "</td>" +
                                "</tr>";
                        });
                        $("#studentList").html(studentTableBody);
                        localStorage.setItem('name', name);
                    } else {
                        $("#studentList").html("<tr><td colspan='1' class='text-center'>학생이 없습니다.</td></tr>");
                        ifNoStudent(name);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('에러 발생:', error);
                    alert('학생 목록을 가져오는 데 실패했습니다.');
                }
            });
        }

        const ifNoStudent = (name) => {
            $('#myModal').modal("show");
            $('#modalTitle').html('학생 없음')
            $('#modalContent').html('해당하는 학생이 없습니다. 추가하시겠습니까?')
            $('#okContent').html('추가하기')
            // "추가하기" 버튼 클릭 시 동작 설정
            $('#okContent').off('click').on('click', function() {
                $('#insertName').val(name)
                $('#edit').attr('hidden', true);
                $('#show').attr('hidden', true);
                $('#insert').removeAttr('hidden');
                $('#myModal').modal("hide");
            });
        }

        const handleInsert = () => {
            const formData = new FormData(document.getElementById('insertForm'));
            const newStudent = {
                name: formData.get('name'),
                place: formData.get('place'),
                school: formData.get('school'),
                dept: formData.get('dept'),
            }
            $.ajax({
                url: 'student/add',
                type: 'POST',
                contentType: 'application/json',  // 서버가 JSON 데이터를 받을 수 있도록 설정
                data: JSON.stringify(newStudent),    // JSON 형식으로 데이터를 전송
                success: function(response) {
                    const name=localStorage.getItem('name');
                    if(name){
                        searchByName(name)
                    }
                    else{
                        loadStudentAll();
                    }
                    $('#myModal').modal("show");
                    $('#modalTitle').html('추가 성공')
                    $('#modalContent').html('추가에 성공했습니다')
                    $('#okContent').html('확인')
                    $('#okContent').off('click').on('click', function() {
                        $('#myModal').modal("hide");
                    });
                    $('#insert').attr('hidden', true);
                    $('#base').removeAttr('hidden');
                    $('#insertName').val('');
                    $('#insertSchool').val('');
                    $('#insertPlace').val('');
                    $('#insertDept').val('');
                },
                error: function(xhr, status, error) {
                    alert('에러 발생: ' + error);
                }
            });
        };

        const handleDelete =() => {
            const idx = $('#hiddenId').val();
            $.ajax({
                url: 'student/delete/'+idx,
                type: 'delete',
                success: function (data) {
                    const name=localStorage.getItem('name');
                    if(name){
                        searchByName(name)
                    }
                    else{
                        loadStudentAll();
                    }
                    $('#show').attr('hidden', true);
                    $('#base').removeAttr('hidden');
                    $('#myModal').modal("show");
                    $('#modalTitle').html('삭제 성공')
                    $('#modalContent').html('삭제에 성공했습니다')
                    $('#okContent').html('확인')
                    $('#okContent').off('click').on('click', function () {
                        $('#myModal').modal("hide");
                    });
                }
            })
        }

        const handleShowInsert = () =>{
            $('#edit').attr('hidden', true);
            $('#show').attr('hidden', true);
            $('#insert').removeAttr('hidden');
            $('#base').attr('hidden', true);
        }

        const handleShow = (id) =>{
            $.ajax({
                url: 'student/'+id,
                type: 'GET',
                success: function(data) {
                    $('#showName').html(data.name);
                    $('#showPlace').html(data.place);
                    $('#showSchool').html(data.school);
                    $('#showDept').html(data.dept);
                    $('#hiddenId').val(data.name_id);
                    $('#editName').val(data.name);
                    $('#editPlace').val(data.place);
                    $('#editSchool').val(data.school);
                    $('#editDept').val(data.dept);


                    $('#edit').attr('hidden', true);
                    $('#insert').attr('hidden', true);
                    $('#show').removeAttr('hidden');
                    $('#base').attr('hidden', true);
                }
            })
        }

        const handleInsertCancel = () =>{
            $('#insert').attr('hidden', true);
            $('#base').removeAttr('hidden');
        }

        const handleCancel = () =>{
            $('#show').removeAttr('hidden');
            $('#edit').attr('hidden', true);
            $('#insert').attr('hidden', true);
            $('#base').attr('hidden', true);
        }
        const handleShowUpdate = () =>{
            $('#edit').removeAttr('hidden');
            $('#show').attr('hidden', true);
            $('#insert').attr('hidden', true);
            $('#base').attr('hidden', true);
        }

        const handleUpdate = () => {
            const formData = new FormData(document.getElementById('updateForm'));
            console.log(formData);
            const newStudent = {
                id: formData.get('id'),
                name: formData.get('name'),
                place: formData.get('place'),
                school: formData.get('school'),
                dept: formData.get('dept')
            }
            console.log(newStudent)
            $.ajax({
                url: 'student/update',
                type: 'Put',
                contentType: 'application/json',
                data: JSON.stringify(newStudent),
                success: function(response) {
                    const name=localStorage.getItem('name');
                    if(name){
                        searchByName(name)
                    }
                    else{
                        loadStudentAll();
                    }
                    handleShow(formData.get('id'));
                    $('#myModal').modal("show");
                    $('#modalTitle').html('수정 성공')
                    $('#modalContent').html('수정에 성공했습니다')
                    $('#okContent').html('확인')
                    $('#okContent').off('click').on('click', function() {
                        $('#myModal').modal("hide");
                    });
                }

            })
        }

    </script>
</head>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel"><p id="modalTitle"></p></h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p id="modalContent"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary"><span id="okContent"></span></button>
            </div>
        </div>
    </div>
</div>
<body>

<div class="container p-2 mt-5">
    <div class="row p-2">
        <div class="col-3">
            <div class="container mb-3 p-0">
                <div class="row d-flex justify-content-between">
                    <div class="col">
                        <input type="text" class="form-control" id="searchName" placeholder="이름 입력"/>
                    </div>
                    <div class="col-auto">
                        <button class="btn btn-secondary" onclick="handleSearch()">검색</button>
                    </div>
                </div>
            </div>

            <div class="container border p-0" style="height:80vh; display: flex; flex-direction: column; justify-content: space-between;">
                <div style="max-height: 110%; overflow-y: auto;">
                <table class="table table-bordered">
                    <tbody id="studentList">
                    <tr>
                        <td class="text-center">
                            <a href="/" class="d-block fs-5 link-secondary link-underline-opacity-0" onclick="handleShow(0, event)">
                                이름
                            </a>
                        </td>
                    </tr>
                    </tbody>
                </table>
                </div>
                <div class="m-2" style="align-self: flex-end;">
                    <button class="btn btn-primary" onclick="handleShowInsert()">추가</button>
                </div>
            </div>

        </div>

        <div class="col-8" id="insert" hidden>
            <div class="container border">
                <form id="insertForm" >
                    <div class="d-flex justify-content-center align-items-center m-3">
                        <table class="table table-bordered">
                            <tr>
                                <td class="col-2">
                                    이름
                                </td>
                                <td class="col-5">
                                    <input type="text" id="insertName" name="name" class="form-control">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    거주하는 동
                                </td>
                                <td>
                                    <input type="text" id="insertPlace" name="place" class="form-control">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    학교
                                </td>
                                <td>
                                    <input type="text" id="insertSchool" name="school" class="form-control">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    전공
                                </td>
                                <td>
                                    <input type="text" id="insertDept" name="dept" class="form-control">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="d-flex justify-content-center align-items-center mb-3">
                        <button type="button" class="btn btn-primary" onclick="handleInsert()">추가</button>
                        <button type="button" class="btn btn-secondary ms-2" onclick="handleInsertCancel()">취소</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-8" id="base">

        </div>

        <div class="col-8 " id="show" hidden>
            <div class="container border">
                <div class="d-flex justify-content-center align-items-center m-3">
                    <table class="table table-bordered">
                        <tr>
                            <td class="col-2">
                                이름
                            </td>
                            <td id="showName" class="col-5">
                                이름
                            </td>
                        </tr>
                        <tr>
                            <td>
                                거주하는 동
                            </td>
                            <td id="showPlace">
                                거주하는 동
                            </td>
                        </tr>
                        <tr>
                            <td>
                                학교
                            </td>
                            <td id="showSchool">
                                학교
                            </td>
                        </tr>
                        <tr>
                            <td>
                                전공
                            </td>
                            <td id="showDept">
                                전공
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="d-flex justify-content-center align-items-center mb-3">
                    <button class="btn btn-primary" onclick="handleShowUpdate()">수정</button>
                    <button class="btn btn-danger ms-2" onclick="handleDelete()">삭제</button>
                </div>
            </div>
        </div>

        <div class="col-8" id="edit" hidden>
            <div class="container border">
                <form id="updateForm">
                <div class="d-flex justify-content-center align-items-center m-3">
                    <input type="text" id="hiddenId" name="id" hidden/>
                    <table class="table table-bordered">
                        <tr>
                            <td class="col-2">
                                이름
                            </td>
                            <td class="col-5">
                                <input type="text" id="editName" name="name" class="form-control">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                거주하는 동
                            </td>
                            <td>
                                <input type="text" id="editPlace" name="place" class="form-control">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                학교
                            </td>
                            <td>
                                <input type="text" id="editSchool" name="school" class="form-control">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                전공
                            </td>
                            <td>
                                <input type="text" id="editDept" name="dept" class="form-control">
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="d-flex justify-content-center align-items-center mb-3">
                    <button type="button" class="btn btn-primary" onclick="handleUpdate()">수정</button>
                    <button type="button" class="btn btn-secondary ms-2" onclick="handleCancel()">취소</button>
                </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
