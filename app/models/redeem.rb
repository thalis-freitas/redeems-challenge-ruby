class Redeem < ApplicationRecord
  belongs_to :user
  belongs_to :redeem_page
  belongs_to :address
  belongs_to :size_option, optional: true

  has_many :answers, dependent: :destroy

  enum :status, { pending: 0, approved: 1, rejected: 2 }

  accepts_nested_attributes_for :answers

  validates :status, presence: true
  validate :prevent_consecutive_redeems, on: :create
  validate :size_option_required_if_redeem_page_has_size_options

  after_save :validate_answers_for_questions

  def self.create_with_user_and_address(redeem_params, user_params, address_params)
    user = find_or_create_user(user_params)
    address = find_or_create_address(address_params)

    redeem = new(redeem_page_id: redeem_params[:redeem_page_id], user: user,
                 address: address, size_option_id: redeem_params[:size_option_id])

    redeem.save_with_answers(redeem_params[:answers])
    redeem
  end

  def save_with_answers(answers)
    ActiveRecord::Base.transaction do
      save!
      create_answers(answers) if answers.present?
    end
  end

  def self.find_or_create_user(user_params)
    user = User.find_or_initialize_by(
      registration_number: user_params[:registration_number].gsub(/\D/, '')
    )

    user.update!(user_params)
    user
  end

  def self.find_or_create_address(address_params)
    address = Address.find_or_initialize_by(
      street: address_params[:street],
      number: address_params[:number],
      zip_code: address_params[:zip_code]
    )

    address.update!(address_params)
    address
  end

  def create_answers(answers_params)
    answers_params.each do |answer_params|
      answers.create!(content: answer_params[:content],
                      question_id: answer_params[:question_id])
    end
  end

  private

  def size_option_required_if_redeem_page_has_size_options
    return unless redeem_page&.size_options&.any? && size_option.nil?

    errors.add(:size_option, I18n.t('errors.messages.blank'))
  end

  def validate_answers_for_questions
    return unless redeem_page&.questions&.any?

    question_ids = redeem_page.questions.pluck(:id)
    answered_question_ids = answers.map(&:question_id)

    missing_questions = question_ids - answered_question_ids

    return unless missing_questions.any?

    errors.add(:answers, I18n.t('errors.messages.missing_answers'))
  end

  def prevent_consecutive_redeems
    return unless Redeem.exists?(user_id: user_id, status: :pending)

    errors.add(:base, I18n.t('errors.messages.consecutive_redeems_not_allowed'))
    throw(:abort)
  end
end
