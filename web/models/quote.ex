defmodule Splurty.Quote do
  use Splurty.Web, :model

  schema "quotes" do
    field :saying, :string
    field :author, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:saying, :author])
    |> validate_required([:author])
  end

end
