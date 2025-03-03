class UpdateUsers2 < ActiveRecord::Migration[4.2]
    def self.up
        change_table :users do |t|
            t.column :app_notification_desktop, :boolean, :default => false
        end
    end

    def self.down
        change_table :users do |t|
            t.remove :app_notification_desktop
        end
    end
end
