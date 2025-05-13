
import { useEffect, useState, useRef } from "react";
import { useToast } from "@/hooks/use-toast";
import { Button } from "@/components/ui/button";
import { MenuDetail, MenuOption, MenuResponse, MenuSelection } from "../types/menu";
import { fetchMenuData, submitMenuSelections } from "../api/menuService";
import { Pizza, ChevronDown } from "lucide-react";
import { ScrollArea } from "@/components/ui/scroll-area";

const MenuSelectionForm = () => {
  const { toast } = useToast();
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [menuData, setMenuData] = useState<MenuResponse | null>(null);
  const [processedDetails, setProcessedDetails] = useState<MenuDetail[]>([]);
  const [activeQuestionIndex, setActiveQuestionIndex] = useState(0);
  const [selections, setSelections] = useState<MenuSelection>({});
  const [showSubmit, setShowSubmit] = useState(false);
  
  // References for each question section
  const questionRefs = useRef<(HTMLDivElement | null)[]>([]);
  const summaryRef = useRef<HTMLDivElement | null>(null);
  
  useEffect(() => {
    const loadMenuData = async () => {
      try {
        const data = await fetchMenuData();
        setMenuData(data);
        
        // Process the menu details to separate the options
        if (data.menu_day_details && data.menu_day_details.length > 0) {
          const details = data.menu_day_details[0].map(detail => {
            const options = detail.MEAL_OPTIONS.split(';').map((opt): MenuOption => ({
              value: opt,
              label: opt
            }));
            
            return {
              ...detail,
              options
            };
          });
          
          setProcessedDetails(details);
          // Initialize the refs array with the correct length
          questionRefs.current = Array(details.length).fill(null);
        }
      } catch (error) {
        console.error("Failed to load menu data:", error);
        toast({
          title: "Error",
          description: "Failed to load menu data. Please try again later.",
          variant: "destructive"
        });
      } finally {
        setLoading(false);
      }
    };

    loadMenuData();
    
    // Set up intersection observer to detect which question is currently in view
    const observerOptions = {
      root: null,
      rootMargin: '-10% 0px -70% 0px', // Trigger when element is 10% from the top and 70% from bottom
      threshold: 0.1
    };
    
    const handleIntersect = (entries: IntersectionObserverEntry[]) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const index = parseInt(entry.target.getAttribute('data-index') || "0");
          setActiveQuestionIndex(index);
        }
      });
    };
    
    const observer = new IntersectionObserver(handleIntersect, observerOptions);
    
    return () => observer.disconnect();
  }, [toast]);
  
  // Setup observers for question elements when they're available
  useEffect(() => {
    const observerOptions = {
      root: null,
      rootMargin: '-10% 0px -70% 0px',
      threshold: 0.1
    };
    
    const handleIntersect = (entries: IntersectionObserverEntry[]) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const index = parseInt(entry.target.getAttribute('data-index') || "0");
          setActiveQuestionIndex(index);
          
          // Check if we're at the summary section
          if (entry.target === summaryRef.current) {
            setShowSubmit(true);
          } else {
            setShowSubmit(false);
          }
        }
      });
    };
    
    const observer = new IntersectionObserver(handleIntersect, observerOptions);
    
    // Observe all question refs
    questionRefs.current.forEach(ref => {
      if (ref) observer.observe(ref);
    });
    
    // Observe the summary section
    if (summaryRef.current) observer.observe(summaryRef.current);
    
    return () => observer.disconnect();
  }, [processedDetails]);

  const handleOptionSelect = (mealIndex: number, option: string) => {
    if (mealIndex >= processedDetails.length) return;
    
    const currentMeal = processedDetails[mealIndex].MEAL;
    setSelections(prev => ({
      ...prev,
      [currentMeal]: option
    }));
    
    // Auto-scroll to the next question after a short delay
    setTimeout(() => {
      if (mealIndex < processedDetails.length - 1) {
        questionRefs.current[mealIndex + 1]?.scrollIntoView({
          behavior: 'smooth',
          block: 'center'
        });
      } else if (summaryRef.current) {
        // If all questions are answered, scroll to the summary
        summaryRef.current.scrollIntoView({
          behavior: 'smooth',
          block: 'center'
        });
      }
    }, 300);
  };

  const handleSubmit = async () => {
    setSubmitting(true);
    try {
      const response = await submitMenuSelections(selections);
      
      toast({
        title: "Success!",
        description: response.message,
      });
      
      // Reset the form
      setSelections({});
      
      // Scroll back to top
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      });
    } catch (error) {
      console.error("Failed to submit selections:", error);
      toast({
        title: "Submission Error",
        description: "Failed to submit your selections. Please try again.",
        variant: "destructive"
      });
    } finally {
      setSubmitting(false);
    }
  };

  const handleScrollToNext = () => {
    if (activeQuestionIndex < processedDetails.length) {
      questionRefs.current[activeQuestionIndex + 1]?.scrollIntoView({
        behavior: 'smooth',
        block: 'center'
      });
    } else if (summaryRef.current) {
      summaryRef.current.scrollIntoView({
        behavior: 'smooth',
        block: 'center'
      });
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="text-center">
          <Pizza className="h-12 w-12 animate-spin text-restaurant-secondary mx-auto mb-4" />
          <p className="text-lg font-medium">Loading today's menu...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="vertical-form-container">
      {/* Progress bar */}
      <div className="progress-bar sticky top-0 z-10">
        <div 
          className="progress-fill" 
          style={{ 
            width: `${(activeQuestionIndex / (processedDetails.length)) * 100}%` 
          }}
        />
      </div>
      
      {/* Menu information */}
      {menuData && (
        <div className="p-6 text-center sticky top-2 bg-white z-10 shadow-sm rounded-t-xl">
          <h2 className="text-2xl font-semibold text-restaurant-primary">{menuData.menu_name} Menu</h2>
          <p className="text-sm text-gray-600">
            Order before {menuData.limit_hour} • {menuData.workday}
          </p>
        </div>
      )}
      
      <ScrollArea className="h-[calc(100vh-220px)] overflow-y-auto pb-20">
        <div className="p-4 space-y-32">
          {/* Question slides - stacked vertically */}
          {processedDetails.map((detail, index) => (
            <div 
              key={detail.ID_MENU_DAY_DETAIL}
              ref={el => questionRefs.current[index] = el} 
              data-index={index}
              className={`question-slide py-16 ${activeQuestionIndex === index ? 'active' : ''}`}
              id={`question-${index}`}
            >
              <h3 className="text-xl font-medium mb-6 text-center">
                Select your {detail.MEAL}
              </h3>
              <div className="w-full max-w-lg">
                {detail.options?.map((option) => (
                  <div
                    key={option.value}
                    className={`option-card ${selections[detail.MEAL] === option.value ? 'selected' : ''}`}
                    onClick={() => handleOptionSelect(index, option.value)}
                  >
                    <div className="flex items-center">
                      <div className="flex-1">
                        <p className="font-medium">{option.label}</p>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
              
              <div className="mt-10 flex justify-center">
                <Button 
                  variant="ghost" 
                  className="flex items-center text-restaurant-primary hover:text-restaurant-primary/80"
                  onClick={handleScrollToNext}
                >
                  Next <ChevronDown className="ml-1 h-4 w-4" />
                </Button>
              </div>
            </div>
          ))}
          
          {/* Summary section */}
          <div 
            ref={summaryRef}
            data-index={processedDetails.length}
            className="question-slide py-16"
            id="summary"
          >
            <h3 className="text-xl font-medium mb-6 text-center">
              Your Menu Selection
            </h3>
            <div className="w-full max-w-lg bg-blue-50 p-6 rounded-xl border border-blue-100">
              {processedDetails.map((detail) => (
                <div key={detail.ID_MENU_DAY_DETAIL} className="mb-4">
                  <h4 className="font-medium text-restaurant-primary">{detail.MEAL}</h4>
                  <p className="text-gray-700">{selections[detail.MEAL] || "Not selected"}</p>
                </div>
              ))}
              
              <div className="mt-8">
                <Button 
                  onClick={handleSubmit} 
                  className="bg-restaurant-primary hover:bg-restaurant-primary/90 text-white w-full"
                  disabled={submitting}
                >
                  {submitting ? "Submitting..." : "Submit Order"}
                </Button>
              </div>
            </div>
          </div>
        </div>
      </ScrollArea>
      
      {/* Fixed Submit button that appears when all selections are made */}
      {showSubmit && Object.keys(selections).length === processedDetails.length && (
        <div className="fixed bottom-6 left-0 right-0 flex justify-center z-20">
          <Button 
            onClick={handleSubmit} 
            className="bg-restaurant-primary hover:bg-restaurant-primary/90 text-white px-8 shadow-lg"
            disabled={submitting}
          >
            {submitting ? "Submitting..." : "Submit Order"}
          </Button>
        </div>
      )}
    </div>
  );
};

export default MenuSelectionForm;
