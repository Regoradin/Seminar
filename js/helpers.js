function RemoveElem(arr, elem){
    for(i=0; i < arr.length; i++){
	if(arr[i] === elem){
	    arr.splice(i, 1);
	}
    }
}

function Test(){
    console.log("WORKING");
}
