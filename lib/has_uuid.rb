module HasUuid
  def self.included(base)
    base.class_eval do
      validates :uuid, presence: true, uniqueness: true
      before_validation :set_uuid, on: :create
    end
  end

  private
    def set_uuid
      self.uuid = SecureRandom.uuid if self.uuid.blank?
    end

end
