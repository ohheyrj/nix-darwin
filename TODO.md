# TODO Report

Generated on: 2025-05-27 11:39:01

Total TODOs found: 6

## flake.nix

### Line 9

**TODO:** `# TODO: Remove the branch when fixed`

**Context:**

```python
      7:     nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
      8:     mac-app-util.url = "github:hraban/mac-app-util";
>>>   9:     # TODO: Remove the branch when fixed
     10:     nix-homebrew.url = "github:zhaofengli/nix-homebrew/drop-24.11-support";
     11:     home-manager.url = "github:nix-community/home-manager";
```

---

## modules/keymapping.nix

### Line 6

**TODO:** `# TODO: Fix this code to be able to run again`

**Context:**

```python
      4:     remapCapsLockToControl = true;
      5:   };
>>>   6:   # TODO: Fix this code to be able to run again
      7:   #  system.activationScripts.postUserActivation.text = ''
      8:   #  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
```

---

## modules/mac-config.nix

### Line 6

**TODO:** `# TODO: Fix this code to be able to run again`

**Context:**

```python
      4:     NSGlobalDomain.AppleInterfaceStyle = "Dark";
      5:   };
>>>   6:   # TODO: Fix this code to be able to run again
      7:   #  system.activationScripts.extraActivation.text = ''
      8:   #  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
```

---

## modules/packages/nix/applications.nix

### Line 20

**TODO:** `# TODO: package calibre`

**Context:**

```python
     18:     nur.repos.ohheyrj.ps-remote-play
     19:     nur.repos.ohheyrj.bartender5
>>>  20:     # TODO: package calibre
     21:     #    calibre
     22:     # TODO: package https://cryptomator.org/for-individuals/
```

---

### Line 22

**TODO:** `# TODO: package https://cryptomator.org/for-individuals/`

**Context:**

```python
     20:     # TODO: package calibre
     21:     #    calibre
>>>  22:     # TODO: package https://cryptomator.org/for-individuals/
     23:     #    cryptomator
     24:   ];
```

---

## modules/packages/nix/dev-tools.nix

### Line 15

**TODO:** `# TODO: fix broken postman package`

**Context:**

```python
     13:     undmg
     14:     cachix
>>>  15:     # TODO: fix broken postman package
     16:     #postman
     17:   ];
```

---

