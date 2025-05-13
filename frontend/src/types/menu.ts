
export interface MenuOption {
  value: string;
  label: string;
}

export interface MenuDetail {
  ID_MENU_DAY_DETAIL: number;
  ID_MENU_DAY: number;
  MEAL: string;
  MEAL_OPTIONS: string;
  options?: MenuOption[];
}

export interface MenuResponse {
  menu_day_details: MenuDetail[][];
  workday: string;
  id_menu_day: number;
  menu_name: string;
  limit_hour: string;
  day_status: number;
}

export interface MenuSelection {
  [key: string]: string;
}
