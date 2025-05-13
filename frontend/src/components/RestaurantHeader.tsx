
import { useEffect, useState } from 'react';

const RestaurantHeader = () => {
  const [date, setDate] = useState<string>('');
  
  useEffect(() => {
    const now = new Date();
    const options: Intl.DateTimeFormatOptions = { 
      weekday: 'long', 
      year: 'numeric', 
      month: 'long', 
      day: 'numeric' 
    };
    setDate(now.toLocaleDateString('en-US', options));
  }, []);

  return (
    <div className="py-8 md:py-12 text-center bg-gradient-to-r from-blue-50 to-blue-100">
      <div className="container mx-auto px-4">
        <h1 className="text-3xl md:text-4xl font-bold text-restaurant-primary mb-3">
          Restaurante Delicioso
        </h1>
        <p className="text-lg font-medium text-restaurant-secondary mb-3">
          Daily Menu Selection
        </p>
        <p className="text-sm text-blue-400">
          {date}
        </p>
      </div>
    </div>
  );
};

export default RestaurantHeader;
