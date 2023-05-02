<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="employee_register.css">
<title>set Alerts</title>
</head>
<body>
	<div class="back" style="float: right">
		<a href='marketplace.jsp'><button>back</button></a>
	</div>
	<div class="home">
		<label style="float: left" class="logoutLblPos"> <a
			href="user_landing.jsp"><button name="home">Home</button></a>
		</label>
	</div>
	<div class="logout">
		<form name="form1" method="post" action="logout">
			<label style="float: right" class="logoutLblPos">
				<button name="logout">logout</button>
			</label>
		</form>
	</div>
	<div class="employee-register">
		<div class="form">
			<form action="setAlert" method="post">

				<div class="form-group">
					<div class="search-div">
						<label for="price">Select maximum Price:</label> <input
							type="number" step=10 class="form-control" id="price"
							name="price">
					</div>
					<div class="search-div">
						<label for="ram">RAM:</label><select class="form-control" id="ram"
							name="ram" multiple>
							<option value="Select All" selected>Select All</option>
							<option value="4 GB">4 GB</option>
							<option value="8 GB">8 GB</option>
							<option value="16 GB">16 GB</option>
							<option value="32 GB">32 GB</option>
						</select>
					</div>
					<div class="search-div">
						<label for="displaySize">Select Maximum Display Size:</label> <input
							type="number" step=0.1 class="form-control" id="displaySize"
							name="displaySize">
					</div>
					<div class="search-div">
						<label for="operatingSystem">Operating System:</label> <select
							class="form-control" id="operatingSystem" name="operatingSystem"
							multiple>
							<option value="Select All" selected>Select All</option>
							<option value="Windows 11">Windows 11</option>
							<option value="Windows 10">Windows 10</option>
							<option value="MacOS">MacOS</option>
							<option value="Linux">Linux</option>
						</select>
					</div>
					<div class="search-div">
						<label for="processor">Processor:</label> <select
							class="form-control" id="processor" name="processor" multiple>
							<option value="Select All" selected>Select All</option>
							<option value="Intel Core">Intel Core</option>
							<option value="AMD Ryzen">AMD Ryzen</option>
							<option value="M1">M1</option>
							<option value="M2">M2</option>
						</select>
					</div>
					<div class="search-div">
						<label for="hdd">HDD Size:</label> <select class="form-control"
							id="hdd" name="hdd" multiple>
							<option value="Select All" selected>Select All</option>
							<option value="256">256 GB</option>
							<option value="512">512 GB</option>
							<option value="1024">1024 GB</option>
							<option value="2048">2048 GB</option>
						</select>
					</div>
					<div class="search-div">
						<label for="processor">Graphics:</label> <select
							class="form-control" id="graphics" name="graphics" multiple>
							<option value="Select All" selected>Select All</option>
							<option value="Nvidia">Nvidia</option>
							<option value="Intel Graphics">Intel Graphics</option>
							<option value="AMD">AMD</option>
						</select>
					</div>
				</div>
				<button type="submit" class="btn btn-primary">Set Alert</button>
			</form>
		</div>

	</div>
</body>
</html>