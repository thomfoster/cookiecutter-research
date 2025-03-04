from setuptools import setup, find_packages

setup(
    name="my_package",
    version="0.1.0",
    description="A package of code to be installed",
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        # Requirements are already handled by requirements.txt",
    ],
)