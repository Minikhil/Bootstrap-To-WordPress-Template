<%
	Dim path: path = Server.MapPath("/resources/images/random_images")
	Dim file_system: Set file_system = Server.CreateObject("Scripting.FileSystemObject")
	Dim images: Set images = (file_system.GetFolder(path)).Files
	
	Dim imgcount
	Dim names: Redim names(images.count)
	
	Dim image: for each image in images
		if right(image.name, 4) = ".jpg" then
			names(imgcount) = image.name
			imgcount = imgcount + 1
		end if
	next
	
	Randomize
	Dim rand1: rand1 = Int(imgcount * Rnd)
	Dim rand2: rand2 = Int((imgcount - 1) * Rnd)
	Dim rand3: rand3 = Int((imgcount - 2) * Rnd)
	
	Dim image1
	Dim image2
	Dim image3
	
	Dim k: for k = 0 to imgcount
		if (rand1 = k) then
			image1 = names(k)
			rand2 = rand2 + 1
			rand3 = rand3 + 1
		elseif (rand2 = k) then
			image2 = names(k)
			rand3 = rand3 + 1
		elseif (rand3 = k) then
			image3 = names(k)
		end if
	next
%>