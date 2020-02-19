function validateForm() {
	var password = document.forms["form"]["password"].value;
	var cpassword = document.forms["form"]["Confirm"].value;

	if (password != cpassword) {
		alert("两次输入密码不一致");
		return false;
	}
}
function updateSubmit(){
	var myform=$('.productform');
	var tmpItem=$("<input type='hidden' name='flag' />");
	tmpItem.attr('value','change');
	myform.append(tmpItem);
	myform.submit();
}
function delSubmit(){
	var myform=$('.productform');
	var tmpItem=$("<input type='hidden' name='flag' />");
	tmpItem.attr('value','del');
	myform.append(tmpItem);
	myform.submit();
}
function UploadImg(obj) {
    var file = obj.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function (e) { 
        var img = document.getElementById("selectImg");
        img.src = e.target.result;
    }}