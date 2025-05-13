
import RestaurantHeader from "@/components/RestaurantHeader";
import MenuSelectionForm from "@/components/MenuSelectionForm";

const Index = () => {
  return (
    <div className="min-h-screen bg-white">
      <RestaurantHeader />
      
      <main className="container mx-auto px-4 py-8">
        <div className="max-w-4xl mx-auto bg-white shadow-sm rounded-2xl">
          <MenuSelectionForm />
        </div>
      </main>
      
      <footer className="container mx-auto px-4 py-6 border-t border-blue-100 mt-12">
        <div className="text-center text-sm text-blue-500">
          <p>&copy; {new Date().getFullYear()} Restaurante Delicioso. All rights reserved.</p>
          <p className="mt-1">Order your daily meal before 9:00 AM</p>
        </div>
      </footer>
    </div>
  );
};

export default Index;
