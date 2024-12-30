class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def call
    raise NotImplementedError, "You must implement the #call method in #{self.class}"
  end

  protected

  def log_error(error)
    Rails.logger.error("[#{self.class.name}] #{error.message}")
  end
end
