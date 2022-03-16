module ProjectsHelper
    def format_price(price)
        "$#{price/ 100.0}"
      end 
      def format_price_to_cents(price)
          return nil if price.nil?
          begin 
            price = price * 100
          rescue
            return nil
          end
          return price
      end
end
