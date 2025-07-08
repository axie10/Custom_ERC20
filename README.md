# 🪙 CustomERC20Token

Un contrato inteligente en Solidity que implementa el estándar [ERC-20](w) desde cero, sin heredar de [OpenZeppelin](w). Esta implementación permite comprender en profundidad cómo funciona internamente un token ERC-20, definiendo su interfaz y sus funciones clave manualmente.

---

## 🚀 Funcionalidades

- Implementación completa del estándar ERC-20.
- Definición manual de la interfaz `IERC20`.
- Gestión de balances, transferencias y aprobaciones.
- Emisión inicial de tokens al deploy del contrato.
- Eventos `Transfer` y `Approval` correctamente definidos.
- Lógica propia para `transfer`, `approve`, `transferFrom` y control de `allowances`.

---

## 📄 Estructura del contrato

- `IERC20`: interfaz oficial con las funciones estándar `totalSupply`, `balanceOf`, `transfer`, `approve`, `allowance`, `transferFrom`.
- `CustomERC20Token`: contrato que implementa la interfaz y gestiona:
  - Supply inicial
  - Asignación de balances
  - Aprobación de gastos
  - Transferencias seguras

---

## 🧠 Aprendizajes clave

- Cómo funciona realmente el estándar ERC-20.
- Por qué los eventos son importantes (`indexed` en `Transfer` y `Approval`).
- Cómo se gestionan los `allowances` (permisos de gasto de terceros).
- Buenas prácticas de seguridad en transferencias y validaciones.

---
