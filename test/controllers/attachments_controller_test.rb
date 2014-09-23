require 'test_helper'

class AttachmentsControllerTest < ActionController::TestCase
  setup do
    @attachment = attachments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attachments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attachment" do
    assert_difference('Attachment.count') do
      post :create, attachment: { classroom_id: @attachment.classroom_id, content: @attachment.content, filename: @attachment.filename, post_id: @attachment.post_id, status: @attachment.status, student_id: @attachment.student_id, teacher_id: @attachment.teacher_id, title: @attachment.title, type: @attachment.type }
    end

    assert_redirected_to attachment_path(assigns(:attachment))
  end

  test "should show attachment" do
    get :show, id: @attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attachment
    assert_response :success
  end

  test "should update attachment" do
    patch :update, id: @attachment, attachment: { classroom_id: @attachment.classroom_id, content: @attachment.content, filename: @attachment.filename, post_id: @attachment.post_id, status: @attachment.status, student_id: @attachment.student_id, teacher_id: @attachment.teacher_id, title: @attachment.title, type: @attachment.type }
    assert_redirected_to attachment_path(assigns(:attachment))
  end

  test "should destroy attachment" do
    assert_difference('Attachment.count', -1) do
      delete :destroy, id: @attachment
    end

    assert_redirected_to attachments_path
  end
end
