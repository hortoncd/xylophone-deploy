# xylophone

Configure a simple xylophone website with nginx

## Supported Platforms

Ubuntu 14.04, 16.04

## Usage

### xylophone::default

Include `xylophone` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[xylophone]"
  ]
}
```

## Testing

There are unit and integration tests for the included cookbook.  These use Docker.

### Unit Tests

The unit tests are a basic `Serverspec` setup.

```
cd xylophone-cookbook && rspec
```

### Integrations Tests

These are a basic `Test Kitchen` setup.  The can be run manually, or by a CI system, as follows:

```
cd xylophone-cookbook && kitchen test
```

## License and Authors

Author:: Chris Horton (hortoncd@gmail.com)
License:: Apache 2.0
