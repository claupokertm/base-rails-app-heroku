module ApplicationHelper
  def redirect_to_js(path, message)
    render 'js_helpers/visit', locals: { path: path, message: message }, formats: [:js]
  end

  def render_form_errors_js(model)
    render 'js_helpers/form_errors', locals: { model: model }, status: 422, formats: [:js]
  end

  def render_error_js(message)
    render 'js_helpers/error', locals: { message: message }, status: 422, formats: [:js]
  end

  def render_ok_js(message)
    render 'js_helpers/ok', locals: { message: message }, formats: [:js]
  end
end
