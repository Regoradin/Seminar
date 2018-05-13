function AddTeacher(teachers, selected_teacher = false){
    
    var div  = document.getElementById("teacher_select");
    var select = document.createElement("select");
    select.name = "teacher"
    div.appendChild(select);
    
    for (var i in teachers){
	var option = document.createElement("option");
	
	option.value = teachers[i][0];
	option.text = teachers[i][1];
	if(selected_teacher == teachers[i][0]){
	    option.selected = true;
	}
	select.appendChild(option);
    }
	
}
