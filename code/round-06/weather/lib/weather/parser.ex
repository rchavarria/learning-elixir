defmodule Weather.Parser do

  require Logger

  def parse({:ok, xml}) do
    Logger.info "XML code got correctly"
    xml
  end
  def parse({:error, error}) do
    Logger.error "Error passed to parser function"
    System.halt(1)
  end
end
