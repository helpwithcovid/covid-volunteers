# frozen_string_literal: true

require "dry/schema/path"
require "dry/schema/macros/dsl"

module Dry
  module Schema
    module Macros
      # A macro used for specifying predicates to be applied to values from a hash
      #
      # @api private
      class Value < DSL
        # @api private
        def call(*predicates, **opts, &block)
          schema = predicates.detect { |predicate| predicate.is_a?(Processor) }

          type_spec = opts[:type_spec]

          if schema
            current_type = schema_dsl.types[name]

            updated_type =
              if array_type?(current_type)
                build_array_type(current_type, schema.type_schema)
              else
                schema.type_schema
              end

            import_steps(schema)

            type(updated_type) unless custom_type? && !current_type.respond_to?(:of)
          end

          trace_opts = opts.reject { |key, _| key == :type_spec || key == :type_rule }

          if (type_rule = opts[:type_rule])
            trace.append(type_rule).evaluate(*predicates, **trace_opts)
            trace.append(new(chain: false).instance_exec(&block)) if block
          else
            trace.evaluate(*predicates, **trace_opts)

            if block && type_spec.equal?(:hash)
              hash(&block)
            elsif type_spec.is_a?(::Dry::Types::Type) && hash_type?(type_spec)
              hash(type_spec)
            elsif block
              trace.append(new(chain: false).instance_exec(&block))
            end
          end

          if trace.captures.empty?
            raise ArgumentError, "wrong number of arguments (given 0, expected at least 1)"
          end

          each(type_spec.type.member) if type_spec.respond_to?(:member)

          self
        end

        # @api private
        def array_type?(type)
          primitive_inferrer[type].eql?([::Array])
        end

        def hash_type?(type)
          primitive_inferrer[type].eql?([::Hash])
        end

        # @api private
        def build_array_type(array_type, member)
          if array_type.respond_to?(:of)
            array_type.of(member)
          else
            raise ArgumentError, <<~ERROR.split("\n").join(" ")
              Cannot define schema for a nominal array type.
              Array types must be instances of Dry::Types::Array,
              usually constructed with Types::Constructor(Array) { ... } or
              Dry::Types['array'].constructor { ... }
            ERROR
          end
        end

        # @api private
        def import_steps(schema)
          schema_dsl.steps.import_callbacks(Path[[*path, name]], schema.steps)
        end

        # @api private
        def respond_to_missing?(meth, include_private = false)
          super || meth.to_s.end_with?(QUESTION_MARK)
        end

        private

        # @api private
        def method_missing(meth, *args, &block)
          if meth.to_s.end_with?(QUESTION_MARK)
            trace.__send__(meth, *args, &block)
          else
            super
          end
        end
      end
    end
  end
end
