defmodule Flextime.Emails.Confirmation do
  @moduledoc false

  import Bamboo.Email
  import Bamboo.Phoenix

  def send do
    create_new("zdenek@sejcek.cz") |> Flextime.Emails.Mailer.deliver_now
  end

  def create_new(to) do
    base_email
    |> to(to)
    |> subject("First Flextime Email")
      # |> put_header("Reply-To", "someone@example.com")
      # |> html_body("<strong>Welcome</strong>")
    |> text_body("Tohle je prvni Flextime email, juchuuuu")
  end

  defp base_email do
    # Here you can set a default from, default headers, etc.
    new_email
    |> from("no-reply@flextime.cz")
    # |> put_html_layout({MyApp.LayoutView, "email.html"})
    # |> put_text_layout({MyApp.LayoutView, "email.text"})
  end

end