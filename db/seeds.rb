jhon_doe = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')

burger_joint = Restaurant.create(name: 'The Burger Joint', address: '123 Main St', description: 'The best burgers in town!', user: jhon_doe)
pizzeria_uno = Restaurant.create(name: 'Pizzeria Uno', address: '456 Elm St', description: 'Authentic New York style pizza!', user: jhon_doe)
thai_palace = Restaurant.create(name: 'Thai Palace', address: '789 Maple Ave', description: 'Delicious Thai cuisine!', user: jhon_doe)

Food.create(name: 'Classic Burger', price: 9.99, description: 'Our signature burger with lettuce, tomato, and pickles', restaurant: burger_joint)
Food.create(name: 'Cheeseburger', price: 10.99, description: 'Our classic burger with melted cheddar cheese', restaurant: burger_joint)
Food.create(name: 'Margherita Pizza', price: 12.99, description: 'Fresh mozzarella, tomato sauce, and basil', restaurant: pizzeria_uno)
Food.create(name: 'Pepperoni Pizza', price: 14.99, description: 'Our Margherita pizza with pepperoni', restaurant: pizzeria_uno)
Food.create(name: 'Pad Thai', price: 14.99, description: 'Stir-fried rice noodles with vegetables and peanuts', restaurant: thai_palace)
Food.create(name: 'Green Curry', price: 15.99, description: 'Spicy Thai curry with coconut milk, vegetables, and your choice of protein', restaurant: thai_palace)
