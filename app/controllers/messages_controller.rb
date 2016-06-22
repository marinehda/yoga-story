class MessagesController < ApplicationController
  #before_action :set_message, only: [:show]

  def list
    @recipient_id = params[:id]
    @messages = policy_scope(Message)
               .where("(@recipient_id = :recipient_id AND user_id = :user_id) OR (user_id = :recipient_id AND @recipient_id = :user_id)", recipient_id: @recipient_id, user_id: current_user)
    @messages = @messages.order(created_at: :desc)
    authorize @messages
    #allow replies in conversation view
    @message = current_user.messages.new
    authorize @message
  end

  def index
    #All messages for which current_user is user or recipient
    @messages = policy_scope(Message)
    #List one occurence all all the recipients for current_user
    @recipients = current_user.messages.collect(&:recipient_id).uniq
    #Return last message of a conversation with a recipient
    @messages_intro = []
    @recipients.each do |recipient|
      #last message when recipient
      last_sent = @messages.where("recipient_id = ? AND user_id = ?", recipient, current_user).last
      #last message when sender
      last_received = @messages.where("recipient_id = ? AND user_id = ?", current_user, recipient).last
      #most recent goes into @messages_intro
      #check if only one message exchanged between users
      if last_sent && last_received
        if last_sent.created_at > last_received.created_at
          @messages_intro << last_sent
        else
          @messages_intro << last_received
        end
      elsif
        last_sent == nil && last_received
        @messages_intro << last_received
      elsif
        last_received == nil && last_sent
        @messages_intro << last_sent
      end
    end
    @messages_intro = @messages_intro.sort_by! &:created_at
    @messages_intro = @messages_intro.reverse!
  end

  def new
    @message = Message.new
  end

  #creation can occur from lesson show or from conversation view hence a few 'if's...
  def create
    @message = current_user.messages.build(message_params)
    if params[:teacher_id]
      @message.recipient_id = params[:teacher_id]
    else
      @message.recipient_id = params[:message][:recipient_id]
    end
    authorize @message
    if @message.save
      if params[:teacher_id]
        redirect_to conversation_path(params[:teacher_id])
      else
        redirect_to conversation_path(params[:message][:recipient_id])
      end
    else
      flash[:alert] = t('.flash_alert')
    end
  end

  private

  def set_message
    @message = Message.find(params[:id])
    authorize @message
  end

  def message_params
    params.require(:message).permit(:content)
  end

end
