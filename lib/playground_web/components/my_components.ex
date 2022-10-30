defmodule MyComponents do
  use Phoenix.Component

  import Phoenix.HTML.Form
  import PlaygroundWeb.ErrorHelpers

  @doc """
  Returns a text input component. 

  ## Example
       
       <.text_input field={{f, :email}} type="email"/>

  Produces the following output: 

      <div class="px-3 mb-4 mt-4 flex-grid">
        <label class="uppercase font-semibold mb-1 text-sm" for="user_email">Email</label>
        <input class="bg-white w-full pl-2 pt-2 pb-2 border border-gray-400 rounded" id="user_email" name="user[email]" phx-debounce="blur" type="email">
      </div>
  """
  attr :form, :string, required: true
  attr :field, :atom, required: true
  attr :label, :boolean, default: true
  attr :label_text, :string, default: nil

  def text_input(assigns) do

    ~H"""
    <div class="px-3 mb-4 mt-4 flex-grid">
      <%= if @label == true do %>
        <%= label(@form, @field, set_label(assigns), class: "label") %>
      <% end %>
      <%= text_input(@form, @field, class: "bg-white w-full pl-2 pt-2 pb-2 border border-gray-400 rounded") %>
      <%= error_tag(@form, @field) %>
    </div>
    """
  end

  defp set_label(%{label_text: nil, field: field}) do
    Phoenix.HTML.Form.humanize(field)
  end

  defp set_label(%{label_text: label_text}) do
    label_text
  end

  attr :text, :string, default: "Submit"

  def submit_btn(assigns) do

    ~H"""
    <div class="px-3 mb-8 mt-8 md:mb-0 flex-grid">
      <button class="submit" type="submit">
        <%= @text %>
      </button>
    </div>
    """
  end

  def checkbox(assigns) do
    {form, field} = assigns.field
    assigns = assign(assigns, :form, form)
    assigns = assign(assigns, :field, field)

    ~H"""
    <div class="px-3 mb-4 mt-4 md:mb-0 flex-grid">
      <%= label(@form, @field) %>
      <%= hidden_input(@form, @field) %>
      <%= text_input(@form, @field, type: "checkbox") %>
    </div>
    """
  end

  @doc """
  Returns a header component. 

  ## Assigns 

  The following assigns are required: 

  * `header_text` - the text that describes the function of the page e.g. Login. 
  * `image` - the full path to the image to display as part of the header component. 

  The following assigns are optional: 

  * `alt_text` - the alternative text for the image. Defaults to the `header_text`. 

  ## Example
       
      <.header header_text="Login" image= "/images/login.svg" />

  Produces the following output: 

      <div class="flex items-center justify-between">
        <div>
          <div class="header">Login</div>
        </div>
        <div>
          <img src="/images/login.svg" alt="Login" class="w-40 h-40">
        </div>
      </div>  
  """
  def header(assigns) do
    assigns = assign_new(assigns, :alt_text, fn -> assigns.header_text end)

    ~H"""
    <div class="flex items-center justify-between">
      <div>
        <div class="header"><%= @header_text %></div>
      </div>
      <div>
        <img src={@image} alt={@alt_text} class="w-40 h-40" />
      </div>
    </div>
    """
  end
end
