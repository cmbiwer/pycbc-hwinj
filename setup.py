import os
from setuptools import setup

def find_package_data(dirname):
    def find_paths(dirname):
        items = []
        for fname in os.listdir(dirname):
            path = os.path.join(dirname, fname)
            if os.path.isdir(path):
                items += find_paths(path)
            elif not path.endswith(".py") and not path.endswith(".pyc"):
                items.append(path)
        return items
    items = find_paths(dirname)
    return [os.path.relpath(path, dirname) for path in items]

project_name = "pycbc-hwinj"
project_version = "0.1.dev0"
project_url = "https://github.com/cmbiwer/pycbc-hwinjlog"
project_description = "A python package for generating a workflow that cross-checks LIGO's various hardware injection logs."
project_keywords = ["ligo", "physics"]

author_name = "Christopher M. Biwer"
author_email = "cmbiwer@gmail.com"

scripts_list = [
    "bin/pycbc_check_frame_excitation",
    "bin/pycbc_check_frame_bitmask",
    "bin/pycbc_cat_frame_data",
    "bin/pycbc_cat_segdb_data",
    "bin/pycbc_make_hwinj_workflow",
    "bin/pycbc_make_hwinj_table",
]

packages_list = [
    "pycbc_hwinj",
    "pycbc_hwinj.results",
]

data_dict = {
    "pycbc_hwinj.results": find_package_data("pycbc_hwinj/results"),
}

setup(name=project_name,
      version=project_version,
      description=project_description,
      url=project_url,
      keywords=project_keywords,
      author=author_name,
      author_email=author_email,
      scripts=scripts_list,
      packages=packages_list,
      package_data=data_dict,
      zip_safe=False,
)
