
import { MenuResponse } from "../types/menu";

// In a real application, this would be a proper API call
export const fetchMenuData = async (): Promise<MenuResponse> => {
  // For this example, we're returning a mock response based on the provided JSON
  // In a real app, this would be: return fetch('/api/menu').then(res => res.json());
  
  // Simulate API request delay
  await new Promise(resolve => setTimeout(resolve, 800));
  
  return {
    "menu_day_details": [
      [
        {
          "ID_MENU_DAY_DETAIL": 1,
          "ID_MENU_DAY": 1,
          "MEAL": "Sopa",
          "MEAL_OPTIONS": "Sopa de Calabaza;Lentejas;Tortilla;Sin Sopa"
        },
        {
          "ID_MENU_DAY_DETAIL": 2,
          "ID_MENU_DAY": 1,
          "MEAL": "Arroz",
          "MEAL_OPTIONS": "Blanco;Cabello de angel;Sin arroz"
        },
        {
          "ID_MENU_DAY_DETAIL": 3,
          "ID_MENU_DAY": 1,
          "MEAL": "Proteina",
          "MEAL_OPTIONS": "Carne;Pollo;Pescado"
        }
      ]
    ],
    "workday": "01-01-2025",
    "id_menu_day": 1,
    "menu_name": "Paisa",
    "limit_hour": "09:00",
    "day_status": 1
  };
};

export const submitMenuSelections = async (selections: Record<string, string>): Promise<{ success: boolean; message: string }> => {
  // Simulate API request delay
  await new Promise(resolve => setTimeout(resolve, 1000));
  
  console.log('Submitted selections:', selections);
  
  // In a real app, this would be a POST request to your API
  return {
    success: true,
    message: 'Your meal selection has been submitted successfully!'
  };
};
