from typing import Optional
from ruamel.yaml import YAML


yaml = YAML()
yaml.width = 200
yaml.preserve_quotes = True
yaml.indent(mapping=2, sequence=4, offset=2)


def reduce_version(version_str: str) -> str:
    # Split the main version from pre-release or build metadata.
    main_parts = version_str.split('+')[0].split('-')

    main_version = main_parts[0]
    pre_release: Optional[str] = None
    if len(main_parts) > 1:
        pre_release = main_parts[1]

    parts = main_version.split('.')

    # If version is below 1.0.0, reset the patch version.
    if parts[0] == '0':
        if len(parts) > 2:
            parts[2] = '0'
    # For versions 1.0.0 and above, reset the minor and patch versions.
    else:
        if len(parts) > 1:
            parts[1:] = ['0', '0']

    reduced_version = '.'.join(parts)

    # Appending back any pre-release label
    if pre_release:
        reduced_version += '-' + pre_release

    return reduced_version


def process_dependencies(dependencies_dict):
    for lib, version in dependencies_dict.items():
        if isinstance(version, str) and '^' in version:
            reduced_ver = reduce_version(version.replace('^', ''))
            dependencies_dict[lib] = f'^{reduced_ver}'
    return dependencies_dict


def process_pubspec(pubspec_path: str):
    with open(pubspec_path, 'r') as file:
        pubspec_data = yaml.load(file)

        pubspec_data['dependencies'] = process_dependencies(
            pubspec_data.get('dependencies', {}))
        pubspec_data['dev_dependencies'] = process_dependencies(
            pubspec_data.get('dev_dependencies', {}))

    with open(pubspec_path, 'w') as file:
        yaml.dump(pubspec_data, file)


process_pubspec('pubspec.yaml')
process_pubspec('example/pubspec.yaml')
