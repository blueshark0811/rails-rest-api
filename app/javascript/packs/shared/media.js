import { css } from 'styled-components';

const sizes = {
  largePort: 768
};

// Iterate through the sizes and create a media template
export const largeViewPort = Object.keys(sizes).reduce((acc, label) => {
  acc[label] = (...args) => css`
    @media (min-width: ${sizes[label] / 16}em) {
      ${css(...args)};
    }
  `;

  return acc;
}, {});
