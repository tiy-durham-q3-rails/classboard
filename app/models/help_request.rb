class HelpRequest < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :nature, presence: true
  validates :attempted, presence: true

  scope :unresolved, -> { where("resolved_at IS NULL").order(created_at: :asc) }
  scope :resolved, -> { where("resolved_at IS NOT NULL").order(resolved_at: :desc) }

  def user_name
    user.try(:name)
  end

  def resolve!
    self.resolved_at = Time.zone.now
    save unless new_record?
  end

  def resolved?
    resolved_at.present?
  end

  def can_edit?(user)
    user == self.user
  end

  def can_resolve?(user)
    can_edit?(user) || user.teacher?
  end
end
