import { Client } from '../lib/supabase'
import { Mail, Phone, Building2, MapPin, Calendar, Trash2 } from 'lucide-react'

interface ClientCardProps {
  client: Client
  onDelete: (id: string) => void
}

export function ClientCard({ client, onDelete }: ClientCardProps) {
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('pt-BR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric'
    })
  }

  return (
    <div className="bg-white rounded-xl shadow-md hover:shadow-lg transition-shadow border border-gray-100 overflow-hidden">
      <div className="p-6">
        <div className="flex items-start justify-between mb-4">
          <div>
            <h3 className="text-xl font-semibold text-gray-900 mb-1">{client.name}</h3>
            <div className="flex items-center text-gray-600 mb-2">
              <Mail className="h-4 w-4 mr-2" />
              <span className="text-sm">{client.email}</span>
            </div>
          </div>
          <button
            onClick={() => onDelete(client.id)}
            className="p-2 text-red-500 hover:bg-red-50 rounded-lg transition-colors"
            title="Excluir cliente"
          >
            <Trash2 className="h-4 w-4" />
          </button>
        </div>

        <div className="space-y-3">
          {client.phone && (
            <div className="flex items-center text-gray-600">
              <Phone className="h-4 w-4 mr-3 text-gray-400" />
              <span className="text-sm">{client.phone}</span>
            </div>
          )}

          {client.company && (
            <div className="flex items-center text-gray-600">
              <Building2 className="h-4 w-4 mr-3 text-gray-400" />
              <span className="text-sm">{client.company}</span>
            </div>
          )}

          {client.address && (
            <div className="flex items-start text-gray-600">
              <MapPin className="h-4 w-4 mr-3 mt-0.5 text-gray-400 flex-shrink-0" />
              <span className="text-sm">{client.address}</span>
            </div>
          )}

          <div className="flex items-center text-gray-500 pt-2 border-t border-gray-100">
            <Calendar className="h-4 w-4 mr-2" />
            <span className="text-xs">Criado em {formatDate(client.created_at)}</span>
          </div>

          {client.notes && (
            <div className="mt-3 p-3 bg-gray-50 rounded-lg">
              <p className="text-sm text-gray-700">{client.notes}</p>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}