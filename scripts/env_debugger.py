from my_package import run
import jax
import os
import subprocess

print("jax version: ", jax.__version__)
print("jax backend: ", jax.lib.xla_bridge.get_backend().platform)
print("jax devices: ", jax.devices())
print()

# print the env variables
print("Environment variables:")
for key, value in os.environ.items():
    print(f"{key}: {value}")
print()

# print the installed python packages
print("Installed packages:")
result = subprocess.run("pip freeze", shell=True, capture_output=True, text=True)
print(result.stdout)
print()

print("Running script/run.py:")
run()