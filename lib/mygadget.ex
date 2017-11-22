defmodule Mygadget do
  alias Nerves.Leds
  alias ElixirALE.GPIO
  require Logger

  def start(_type, _args) do
    led_name = Application.get_env(:mygadget, :led_name)
    input_pin = Application.get_env(:mygadget, :input_pin)
    Logger.debug "LED name: #{led_name}"
    Logger.debug "Input pin: #{input_pin}"

    Logger.info "Starting pin #{input_pin} as input"
    {:ok, input_pid} = GPIO.start_link(input_pin, :input)

    led_pid = spawn fn -> handle_led(led_name) end

    spawn fn -> wait_for_input(led_pid, input_pid) end

    {:ok, self()}
  end

  defp handle_led(led_name) do
    receive do
      :on ->
        Leds.set [{led_name, true}]
      :off ->
        Leds.set [{led_name, false}]
    end

    handle_led(led_name)
  end

  defp wait_for_input(led_pid, input_pid) do
    GPIO.set_int(input_pid, :both)

    listen_for_input(led_pid)
  end

  defp listen_for_input(led_pid) do
    receive do
      {:gpio_interrupt, p, :rising} ->
        send led_pid, :on
      {:gpio_interrupt, p, :falling} ->
        send led_pid, :off
    end

    listen_for_input(led_pid)
  end
end
