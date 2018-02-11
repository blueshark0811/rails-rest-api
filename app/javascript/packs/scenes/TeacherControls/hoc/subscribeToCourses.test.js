jest.mock('./subscribeToCourses.js');
import subscribeToCourses from './subscribeToCourses';

describe('Subscribe to courses', () => {
  it('should throw error if the pass input is not component', () => {
    // we will mock the real implementation of the subscribeToCourses.
    subscribeToCourses.mockImplementation(WrappedComponent => {
      if (typeof WrappedComponent !== 'function') {
        throw new Error('The input is not a component');
      }
    });

    expect(() => subscribeToCourses('im a string')).toThrow();
  });
});
