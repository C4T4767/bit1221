<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>TITLE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
    <script>
        const handleSearch = () =>{
            $('#myModal').modal("show");
            $('#modalTitle').html('학생 없음')
            $('#modalContent').html('해당하는 학생이 없습니다. 추가하시겠습니까?')
            $('#okContent').html('추가하기')
            // "추가하기" 버튼 클릭 시 동작 설정
            $('#okContent').on('click').on('click', function() {
                $('#edit').attr('hidden', true);
                $('#show').attr('hidden', true);
                $('#insert').removeAttr('hidden');
                $('#myModal').modal("hide");
            });
        }

        const handleInsert = () => {
            const formData = new FormData(document.getElementById('insertForm'));
            $.ajax({
                url: '/your-server-endpoint',  // 실제 서버 주소로 변경 필요
                type: 'POST',
                data: formData,
                processData: false,  // 파일 업로드 시 필요
                contentType: false,  // 파일 업로드 시 필요
                success: function(response) {
                    alert('추가되었습니다!');
                    $('#insert').attr('hidden', true);  // 추가 폼 숨기기
                },
                error: function(xhr, status, error) {
                    alert('에러 발생: ' + error);
                }
            });
        };


        const handleShowInsert = () =>{
            $('#edit').attr('hidden', true);
            $('#show').attr('hidden', true);
            $('#insert').removeAttr('hidden');

        }

        const handleShow = (idx, event) =>{
            event.preventDefault();
            $('#show').removeAttr('hidden');
        }

        const handleInsertCancel = () =>{
            $('#insert').attr('hidden', true);
        }

        const handleCancel = () =>{
            $('#show').removeAttr('hidden');
            $('#edit').attr('hidden', true);
        }
        const handleEdit = () =>{
            $('#edit').removeAttr('hidden');
            $('#show').attr('hidden', true);
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

<div class="container mt-5">
    <div class="row">
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
                <table class="table table-primary table-bordered">
                    <tr>
                        <td class="text-center">
                            <a href="/" class="d-block fs-5 link-secondary link-underline-opacity-0" onclick="handleShow(1, event)">
                                이름1
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-center">
                            <a href="/" class="d-block">
                                이름2
                            </a>
                        </td>
                    </tr>
                </table>

                <div class="m-2" style="align-self: flex-end;">
                    <button class="btn btn-primary" onclick="handleShowInsert()">추가</button>
                </div>
            </div>

        </div>
        <div class="col-7" id="insert" hidden>
            <div class="container border">
                <form id="insertForm" >
                    <div class="d-flex justify-content-center align-items-center m-3">
                        <table class="table table-bordered">
                            <tr>
                                <td class="col-2">
                                    이름
                                </td>
                                <td class="col-5">
                                    <input type="text" name="name" class="form-control">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    거주하는 동
                                </td>
                                <td>
                                    <input type="text" name="place" class="form-control">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    학교
                                </td>
                                <td>
                                    <input type="text" name="school" class="form-control">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    전공
                                </td>
                                <td>
                                    <input type="text" name="dept3" class="form-control">
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

        <div class="col-7" id="show" hidden>
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
                    <button class="btn btn-primary" onclick="handleEdit()">수정</button>
                    <button class="btn btn-warning ms-2">삭제</button>
                </div>
            </div>
        </div>
        <div class="col-7" id="edit" hidden>
            <div class="container border">
                <form id="editForm">
                <div class="d-flex justify-content-center align-items-center m-3">
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
                    <button type="button" class="btn btn-primary">수정</button>
                    <button type="button" class="btn btn-secondary ms-2" onclick="handleCancel()">취소</button>
                </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
