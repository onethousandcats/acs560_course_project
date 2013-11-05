CREATE TABLE Restaurant(
	name VARCHAR(100) PRIMARY KEY
);
CREATE TABLE Meal(
	name VARCHAR(100) PRIMARY KEY,
	calories INTEGER,
	fat INTEGER,
	saturated_fat INTEGER,
	trans_fat INTEGER,
	cholesterol INTEGER,
	sodium INTEGER,
	carbohydrates INTEGER,
	fiber INTEGER,
	sugar INTEGER,
	protein INTEGER,
	vitamin_a INTEGER,
	vitamin_c INTEGER,
	calcium INTEGER,
	iron INTEGER
);