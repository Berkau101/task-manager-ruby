class Task < ApplicationRecord
  belongs_to :user

  STATUSES = {
    "pending"     => "Bekliyor",
    "in_progress" => "Devam Ediyor",
    "completed"   => "Tamamlandı"
  }.freeze

  validates :title, presence: true, length: { minimum: 5 }
  validates :due_date, presence: true
  validates :status, inclusion: { in: STATUSES.keys }
  validate  :due_date_cannot_be_in_the_past

  scope :completed, -> { where(status: "completed") }
  scope :pending,   -> { where(status: "pending") }
  scope :due_soon, ->(days = 7) {
    where(due_date: Date.current..(Date.current + days.days)).order(:due_date)
  }

  def status_label
    STATUSES[status]
  end

  private

  def due_date_cannot_be_in_the_past
    return if due_date.blank?

    if due_date < Date.current
      errors.add(:due_date, "geçmiş bir tarih olamaz")
    end
  end
end