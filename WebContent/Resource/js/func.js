
       function validateForm()
        {
        var password=document.forms["form"]["password"].value;
        var cpassword=document.forms["form"]["Confirm"].value;

        if (password!=cpassword)
        {
            alert("两次输入密码不一致");
            return false;
        }
        }
        
