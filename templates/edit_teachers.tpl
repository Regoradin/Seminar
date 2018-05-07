<form action="teachers/new" method="POST">
	<input type="submit" value="Add New Teacher">
</form>
%for teacher in teachers:
<form action="teachers" method="POST">
	%id = teacher[0]
	%value = "Remove " + teacher[1]
	<input type="hidden" name=teacher_id value={{id}}
	<input type="submit" value={{value}}>
</form>
%end