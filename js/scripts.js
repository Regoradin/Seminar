function AddTeacher(teachers, selected_teacher = false){
    
    var div  = document.getElementById("teacher_select");
    var select = document.createElement("select");
    select.name = "teacher"
    div.appendChild(select);
    
    for (var i in teachers){
	var option = document.createElement("option");
	
	option.id = teachers[i][0];
	option.value = teachers[i][0];
	option.text = teachers[i][1];
	if(selected_teacher == teachers[i][0]){
	    option.selected = true;
	}
	select.appendChild(option);
    }
	
}
function RemoveTeacher(teacher_id){
    var div = document.getElementById("teacher_remove");
    var remove = document.createElement("button");
    div.appendChild(button);

    button.onclick = function(){RemoveElement(teacher_id);}
}

function RemoveElement(id){
    console.log("Removing");
    var elem = document.getElementById(id);
    elem.parentNode.removeChild(elem);
}
