truncate table Restaurant;
truncate table Meal;

insert into Restaurant values ("Subway", "Sandwich");
insert into Restaurant values ("Jimmy Johns", "Sandwich");
insert into Restaurant values ("Chipotle", "Mexican");
insert into Restaurant values ("Qdoba", "Mexican");
insert into Restaurant values ("Panera", "Bakery-Cafe");
#insert into Restaurant values ("McDonalds", "American Fast Food");
insert into Restaurant values ("Burger King", "American Fast Food");

insert into Meal values ("6 inch BLT",320, 9, 20, 650, "Subway");
insert into Meal values ("6 inch Big Philly Cheesesteak",500, 17, 85, 1280, "Subway");
insert into Meal values ("6 inch Chicken Bacon Ranch",570, 28, 95, 1050, "Subway");
insert into Meal values ("6 inch Spicy Italian",410, 16, 45, 1060, "Subway");
insert into Meal values ("6 inch Sriracha Chicken",400, 11, 70, 870, "Subway");
insert into Meal values ("6 inch Steak and Bacon",500, 16, 85, 1550, "Subway");
insert into Meal values ("Pepe",580, 29, 55, 1380, "Jimmy Johns");
insert into Meal values ("Turkey Tom",485, 20, 40, 1060, "Jimmy Johns");
insert into Meal values ("Chicken White Rice Burrito",650, 19, 115, 1240, "Chipotle");
insert into Meal values ("Burrito with Cheese",405, 14, 25, 1090, "Qdoba");
insert into Meal values ("Plain Bagel",290, 1, 0, 460, "Panera");
insert into Meal values ("Broccoli Cheddar Soup",330, 21, 75, 1390, "Panera");
#insert into Meal values ("Big Mac",550, 29, 75, 970, "McDonalds");
#insert into Meal values ("Small French Fries",230, 11, 0, 160, "McDonalds");
insert into Meal values ("Whopper",630, 35, 65, 980, "Burger King");
insert into Meal values ("Chicken Nuggets (4 pc)",190, 11, 25, 310, "Burger King");
Select * from Meal;