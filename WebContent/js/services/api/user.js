/**
 * 
 */

if(!HENESYS_API) {
	var HENESYS_API = {}
}

HENESYS_API.User = function () {}

HENESYS_API.User.prototype.getUsers = function () {
 	var users = $.ajax({
        type: "GET",
        url: heneServerPath + "/user?id=all",
        success: function (result) {
        	return result;
        }
	});
    
	return users;
}

HENESYS_API.User.prototype.getSelectedUsers = function (loginID) {
	console.log(loginID);
 	var users = $.ajax({
        type: "GET",
        url: heneServerPath + "/user?id=" + loginID,
        success: function (result) {
        	return result;
        }
	});
    
	return users;
}
