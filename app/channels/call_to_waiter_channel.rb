class CallToWaiterChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "calltowaiter_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
