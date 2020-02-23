function validateForm() {
	var password = document.forms["form"]["password"].value;
	var cpassword = document.forms["form"]["Confirm"].value;

	if (password != cpassword) {
		alert("两次输入密码不一致");
		return false;
	}
}
function updateSubmit(button){
	var myform=$(button).parent().parent();
	var tmpItem=$("<input type='hidden' name='flag' />");
	tmpItem.attr('value','change');
	myform.append(tmpItem);
	myform.submit();
}
function delSubmit(button){
	var myform=$(button).parent().parent();
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
function changeclass(id){
	if(id==2){
	$('#'+(id-1).toString()).removeClass('selected');
	$('#'+id.toString()).addClass('selected');
	}else if(id==3){
		$('#'+(id-1).toString()).removeClass('selected');
		$('#'+(id-2).toString()).removeClass('selected');
		$('#'+id.toString()).addClass('selected');
	}
}
function del_product(ev){
	var M_tr=$(ev).parent().parent();
	M_tr.remove();
	change_total()
}
function figure(ev){
	var M_tr=$(ev).parent().parent();
	M_tr.find("[id='totalprice']").html('￥'+String(parseInt($(ev).val())*parseFloat(M_tr.find("[name='price']").val())));
	change_total()
}
function change_total(){
		var Price=0.0;
		var count=0;
	$('tr').find("#totalprice").each(function(){
		Price+=parseFloat($(this).html().replace('￥',''));
	})
	$('tr').find('#prodcount').each(function(){
		count+=parseInt($(this).val());
	})
	$('#totalcount').html(count);
	$('#totalprices').html(Price)
}
