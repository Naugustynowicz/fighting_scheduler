class Circuit < ApplicationRecord
  def add_event(event)
    event.update! circuit_id: self.id
  end

  def remove_event(event)
    event.update! circuit_id: nil
  end
end
