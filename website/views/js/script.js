document.getElementById('login-form').addEventListener('submit', function(event) {
    event.preventDefault();
    var username = document.getElementById('username').value;
    var password = document.getElementById('password').value;
    // You can add your login logic here, for demonstration purposes let's just log the inputs
    console.log('Username:', username);
    console.log('Password:', password);
    // Here you can add AJAX requests or other logic to handle the login process
});
