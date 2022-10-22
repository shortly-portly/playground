defmodule PlaygroundWeb.SimpleForm do
  use PlaygroundWeb, :live_view

  defmodule Form do
    use Ecto.Schema
    import Ecto.Changeset

    embedded_schema do
      field :name, :string
      field :age, :integer
      field :agree, :boolean, default: false
    end

    def changeset(form, params) do
      form
      |> cast(params, [:name, :age])
    end
  end

  def render(assigns) do
    ~H"""
    <.form for={@changeset} :let={f} phx-change="validate" phx-submit="submit">
      <.text_input form={f} field={:name} label_text={"Hope" } />
      <.text_input form={f} field={:age } />
      <.checkbox field={{f, :agree}} />
      <.submit_btn />
    </.form>
    """
  end

  def mount(_params, _session, socket) do
    form = %Form{}
    changeset = Form.changeset(%Form{}, %{})
    options = [{1, 'Tea'}, {2, 'Cheese'}, {3, 'Lager'}]

    socket =
      socket
      |> assign(form: form)
      |> assign(changeset: changeset)
      |> assign(options: options)

    {:ok, socket}
  end

  def handle_event("validate", %{"form" => params}, socket) do
    dbg(params)

    changeset =
      socket.assigns.form
      |> Form.changeset(params)
      |> struct!(action: :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end
end
