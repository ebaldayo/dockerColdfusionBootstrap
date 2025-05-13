
import { MenuResponse } from "../types/menu";

export async function fetchMenuData(day: string): Promise<any> {
  try {
    
    const response = await fetch(`http://localhost:8500/rest/v1/menu/13-05-2025`);

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const data = await response.json();

    return data;
  } catch (error) {
    console.error("Failed to fetch menu data:", error);
    throw error;
  }
}

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
