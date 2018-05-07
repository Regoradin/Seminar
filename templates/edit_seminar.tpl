%id = seminar[0]
%title = seminar[1]
%description = seminar[2]

<p>Edit Seminar:</p>

<form action="edit" method="POST">
	<input type="hidden" name="id" value="{{id}}">
	<input type="text" name="title" value={{title}}>
	<input type="text" name="description" value={{description}}>
	<input type="submit" name="save" value="save">
</form>

<form action="edit/teachers" method="POST">
	<input type="hidden" name="sems_id" value="{{sems_id}}">
	<input type="submit" value="Edit Teachers">
</form>